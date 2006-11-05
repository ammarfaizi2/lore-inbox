Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWKEKTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWKEKTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWKEKTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:19:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45959 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932625AbWKEKTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:19:47 -0500
Subject: Re: Need help in writing Layered driver in Linux
From: Arjan van de Ven <arjan@infradead.org>
To: "Palakodeti, Srinivasa Rao (STSD)" <palakodetisrinivasa.rao@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B57F74065657FA4F85110272279E461B016F6F19@BGEEXC07.asiapacific.cpqcorp.net>
References: <B57F74065657FA4F85110272279E461B016F6F19@BGEEXC07.asiapacific.cpqcorp.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 05 Nov 2006 11:19:44 +0100
Message-Id: <1162721984.3160.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 12:20 +0530, Palakodeti, Srinivasa Rao (STSD)
wrote:
> Hi All, 
> 
> I want to write a layered driver for a device in Linux. 

Hi,

the best way to do that is to make a plugin for DeviceMapper, that's the
generic remapping layer in the linux kernel....
see drivers/md/

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

