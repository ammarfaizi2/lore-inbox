Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753945AbWKRFtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbWKRFtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbWKRFtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:49:49 -0500
Received: from main.gmane.org ([80.91.229.2]:13037 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1753945AbWKRFts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:49:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 18/20] x86_64: Relocatable kernel support
Date: Sat, 18 Nov 2006 05:49:34 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelt84v.dd3.olecom@flower.upol.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117225718.GS15449@in.ibm.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz, vgoyal@in.ibm.com, Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com, akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-17, Vivek Goyal wrote:
[]
>  static void error(char *x)
> @@ -281,57 +335,8 @@ static void error(char *x)
>  	while(1);	/* Halt */
>  }

Is it possible to make this optional (using "panic" reboot timeout)?
____

