Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUGZAJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUGZAJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUGZAJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:09:57 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:10913 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264643AbUGZAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:09:52 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Date: Sun, 25 Jul 2004 20:09:03 -0400
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407251945.18055.rpc@cafe4111.org> <200407260156.14896.cijoml@volny.cz>
In-Reply-To: <200407260156.14896.cijoml@volny.cz>
Cc: cijoml@volny.cz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407252009.03770.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 07:56 pm, Bc. Michal Semler wrote:
> Wow :) 3years old todo :)
> This is the way, how to make good os :)

TODO? i thought it means it's done...

grep -n  ethtool drivers/net/3c59x.c
151:    - Add ethtool support (jgarzik)
254:#include <linux/ethtool.h>
877:static struct ethtool_ops vortex_ethtool_ops;
1342:   dev->ethtool_ops = &vortex_ethtool_ops;
2704:                           struct ethtool_drvinfo *info)
2717:static struct ethtool_ops vortex_ethtool_ops = {

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
    -unless Internet Explorer is involved.
--
