Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289643AbSAOUbk>; Tue, 15 Jan 2002 15:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSAOUba>; Tue, 15 Jan 2002 15:31:30 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62947 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289643AbSAOUbT>;
	Tue, 15 Jan 2002 15:31:19 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 15 Jan 2002 20:31:16 GMT
Message-Id: <UTC200201152031.UAA395407.aeb@cwi.nl>
To: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: struct gendisk max_p gone in 2.5.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The max_p member of struct gendisk was deleted in 2.5.x.
> Is there a different preferred method for partition detection code
> to know the maximum number of partitions it's allowed to present?

Instead of using g->max_p you can use 1<<g->minor_shift .

Andries
