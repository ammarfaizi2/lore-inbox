Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbTHTNPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTHTNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:15:06 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:16653 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S261933AbTHTNPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:15:04 -0400
Message-Id: <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Sergey Spiridonov <spiridonov@gamic.com>, linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
Date: Wed, 20 Aug 2003 16:11:42 +0300
X-Mailer: KMail [version 1.3.2]
References: <3F4360F0.209@gamic.com>
In-Reply-To: <3F4360F0.209@gamic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 August 2003 14:52, Sergey Spiridonov wrote:
> Hi,
> 
> I need to make some performance tests. I need to switch off or to clear 
> read cache, so that consequent reading of the same file will take the 
> same amount of time.

umount/mount cycle will do it, as well as intentional OOMing the box
(from non-root account please;)
--
vda
