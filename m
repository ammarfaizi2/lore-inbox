Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTJ3DWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJ3DWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:22:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262190AbTJ3DWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:22:04 -0500
Date: Wed, 29 Oct 2003 22:22:50 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: paulus@samba.org, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <davem@redhat.com>
Subject: Re: Bug somewhere in crypto or ipsec stuff
In-Reply-To: <20031030.121732.12858700.yoshfuji@linux-ipv6.org>
Message-ID: <Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:


> I would just disallow name == NULL,
> well, what algorithm do you expect?

Good question.  It seems to me to be a bug in the calling code if it is 
trying to look up nothing -- I'd rather not paper that over.


- James
-- 
James Morris
<jmorris@redhat.com>


