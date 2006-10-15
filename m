Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWJOTRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWJOTRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWJOTRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:17:18 -0400
Received: from web27401.mail.ukl.yahoo.com ([217.146.177.177]:15284 "HELO
	web27401.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030252AbWJOTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:17:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PouBrKlwctXz8yweB++yWVZDVOwKg9HadEliZ+k/+3s6epX11B8vc8IZHeXKOqoato/OpkSX+ZLruLahNBoRgu43iNStsVh36OMGMPafqFk2yRpsKrxTP4y9ScFPrD9tiXIV0SuMH7fOHO9OHpjW/S1v43aUctf0GDkovLn99AM=  ;
Message-ID: <20061015191716.15283.qmail@web27401.mail.ukl.yahoo.com>
Date: Sun, 15 Oct 2006 20:17:16 +0100 (BST)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: privilege levels and kernel mode
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610151141280.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am using pentium-4 processor. My operating
system  is Linux version 2.4.22-1.2199.nptl

  I want to measure performance events like number of
memory reads, number of cache misses occured while
running  a "C" program. For that I have to wright some
values into "Model specific registers of pentium-4
processor". But those registers can be written ONLY at
privilege level of zero of pentium4 processor.

 We know that application programs we write (for
example any C program)are run at privilege
level-3(user mode).

I know how to include assembly instructions in a C
program to wtrite into "Model specific registers". But
that program has to be run at privilege level zero.

How to run a C program at privilege level zero??
Can any one help me?

Thanks in advance.

 

Send instant messages to your online friends http://uk.messenger.yahoo.com 
