Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRCEUFx>; Mon, 5 Mar 2001 15:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRCEUFn>; Mon, 5 Mar 2001 15:05:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:41394 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130399AbRCEUFh>;
	Mon, 5 Mar 2001 15:05:37 -0500
Date: Mon, 5 Mar 2001 21:05:35 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103052005.VAA74162.aeb@vlet.cwi.nl>
To: leitner@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: chown bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Felix von Leitner <leitner@fefe.de>

    If user !root says chown("/usr",-1,-1), he gets EPERM.  Why?

Because the standard says:

  The chown( ) function shall fail if:

  [EPERM]  The effective user ID does not match the owner of the file, or ..

Andries
