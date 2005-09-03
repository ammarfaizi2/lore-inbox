Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVICMws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVICMws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 08:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVICMws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 08:52:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35048 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751169AbVICMwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 08:52:47 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c via686a.c: save at least 0.5k of space by long v[256] -> u16 v[256]
Date: Sat, 3 Sep 2005 15:51:51 +0300
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
References: <200509010910.14824.vda@ilport.com.ua> <200509020854.37192.vda@ilport.com.ua> <20050903102656.117e4dbe.khali@linux-fr.org>
In-Reply-To: <20050903102656.117e4dbe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031551.51564.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 11:26, Jean Delvare wrote:
> Hi Denis,
> 
> BTW...
> 
> > Please be informed that there are lots of intNN_t's in i2c dir
> > tho...
> 
> I couldn't find any. What were you refering to exactly?

Sorry I was wrong. While kernel has ~15000 [u]intNN_t's
they are all _not_ in i2c.
--
vda
