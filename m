Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUGZASp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUGZASp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUGZASp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:18:45 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:48910 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S264660AbUGZASi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:18:38 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: rpc@cafe4111.org
Subject: Re: 3C905 and ethtool
Date: Mon, 26 Jul 2004 02:18:29 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407260156.14896.cijoml@volny.cz> <200407252009.03770.rpc@cafe4111.org>
In-Reply-To: <200407252009.03770.rpc@cafe4111.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407260218.29966.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry you are right.

Jeff do you remember what did you do in ethtool support?


Dne po 26. èervence 2004 02:09 Rob Couto napsal(a):
> On Sunday 25 July 2004 07:56 pm, Bc. Michal Semler wrote:
> > Wow :) 3years old todo :)
> > This is the way, how to make good os :)
>
> TODO? i thought it means it's done...
>
> grep -n  ethtool drivers/net/3c59x.c
> 151:    - Add ethtool support (jgarzik)
> 254:#include <linux/ethtool.h>
> 877:static struct ethtool_ops vortex_ethtool_ops;
> 1342:   dev->ethtool_ops = &vortex_ethtool_ops;
> 2704:                           struct ethtool_drvinfo *info)
> 2717:static struct ethtool_ops vortex_ethtool_ops = {
