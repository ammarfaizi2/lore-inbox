Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVCWGth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVCWGth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCWGtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:49:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28839 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262828AbVCWGtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:49:33 -0500
Date: Wed, 23 Mar 2005 07:49:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "shafa.hidee" <shafa.hidee@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: specifying license
In-Reply-To: <001f01c52f74$2fe3d7a0$6a88cb0a@hss.hns.com>
Message-ID: <Pine.LNX.4.61.0503230748450.21578@yvahk01.tjqt.qr>
References: <001f01c52f74$2fe3d7a0$6a88cb0a@hss.hns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi ,
>      How to specify LICENSE tag in a driver module so that module is marked
>as tainted while loading.

#include <linux/module.h>
MODULE_LICENSE("GPL");

Note that tained == (a license != GPL/BSD/similar)


Jan Engelhardt
-- 
