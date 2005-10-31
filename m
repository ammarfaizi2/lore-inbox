Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVJaUdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVJaUdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVJaUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:33:04 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:52891 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S932495AbVJaUdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:33:03 -0500
Date: Mon, 31 Oct 2005 12:29:26 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Joel Becker <joel.becker@oracle.com>, Zach Brown <zach.brown@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>,
       Sunil Mushran <sunil.mushran@oracle.com>,
       Manish Singh <manish.singh@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/ocfs2/: possible cleanups
Message-ID: <20051031202926.GA21298@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20051030004308.GR4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030004308.GR4180@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 30, 2005 at 02:43:08AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - every function should #include the headers with the prototypes of it's
>   global functions
> - #if 0 unused code
Thanks for this - I took the liberty of going through the #if 0'd code and
removing most of it as it could be trivially reproduced once we actually
needed it. The rest have comments explaining why they should remain.

This change will be in our git repository later today.

The patch as committed can be found at:
http://oss.oracle.com/pipermail/ocfs2-commits/2005-October/001973.html
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

