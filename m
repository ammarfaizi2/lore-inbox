Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbUKXXAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUKXXAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbUKXXA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:00:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10937 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262895AbUKXWrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:47:21 -0500
To: oliver@neukum.org
CC: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@Osdl.ORG,
       hbryan@us.ibm.com, akpm@Osdl.ORG, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <200411242001.59504.oliver@neukum.org> (message from Oliver
	Neukum on Wed, 24 Nov 2004 20:01:58 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <200411242001.59504.oliver@neukum.org>
Message-Id: <E1CX2gj-0007z8-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Nov 2004 20:20:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both are limited in the number of pages they can dirty by the number
> of pages available. If you are willing to limit your filesystem the same
> way you enjoy the same benefit.

This limitation will in the worst case cause a performance problem,
but userspace filesystems will have inferior performace to in-kernel
filesystems anyway.  So I don't regard this a problem.

Miklos
