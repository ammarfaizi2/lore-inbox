Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUAIQnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUAIQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:43:53 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:18616 "EHLO
	columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id S262794AbUAIQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:43:52 -0500
Message-ID: <3FFEDA46.8080708@jburgess.uklinux.net>
Date: Fri, 09 Jan 2004 16:43:50 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem - 2.6.0 Kernel and irq 18: nobody cared!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Christian Treusch  wrote:
 > Mainboard is an Asus P4P800 Deluxe (Intel i865PE Chipset)

This looks like the same problem which Raphaël RIGO mentioned recently.
There seems to be a problem with the handling of the IDE controller when 
it is in native mode.
The workaround provided by Matthias Hentges was as follows:

 > The trick for me was to configure "Enhanced Mode, SATA only" in
 > the BIOS.
 > See http://www.hentges.net/howtos/p4p800_SATA.html for details.


    Jon


