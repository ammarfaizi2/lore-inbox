Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTJRDMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 23:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJRDMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 23:12:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:38855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261270AbTJRDMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 23:12:15 -0400
Date: Fri, 17 Oct 2003 20:10:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console escape sequences
Message-Id: <20031017201052.2c8d3221.rddunlap@osdl.org>
In-Reply-To: <20031018000531.GB17198@DervishD>
References: <20031018000531.GB17198@DervishD>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Oct 2003 02:05:31 +0200 DervishD <raul@pleyades.net> wrote:

|     Hi all :)
| 
|     Where should I look if I want to know which ANSI escape codes (or
| any other escape codes) the console accepts? I know that I can send
| ESC[1m; to the console for getting bold text, for example, and I know
| more codes, extracted from the terminfo entries and places like that,
| but I would like to know if somewhere in the sources is something
| like a list of supported codes.

Maybe 'man 4 console_chars' ?

CONSOLE_CODES(4)           Linux Programmer's Manual          CONSOLE_CODES(4)

NAME
       console_codes - Linux console escape and control sequences

DESCRIPTION
       The   Linux  console  implements  a  large  subset  of  the  VT102  and
       ECMA-48/ISO 6429/ANSI X3.64 terminal controls,  plus  certain  private-
       mode  sequences  for changing the color palette, character-set mapping,
       etc.

--
~Randy
