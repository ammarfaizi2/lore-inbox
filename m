Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWAUBqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWAUBqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAUBqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:46:49 -0500
Received: from web34107.mail.mud.yahoo.com ([66.163.178.105]:49847 "HELO
	web34107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932384AbWAUBqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:46:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pSScrp9yUEJ/gRR0IiwEzY7rmG9Zryrz7QKk6oIhSjRlCaGnkrPIZucntfdxCLku6Iuny6BxySTq+QmR+pRrqX4XbVusUDxGj913Xii9GYNR0DmyBlqG/GQXKLD3/6x1PM8Q8PpbE1xzgsM5Q/5Hr2i8z8rglcT0XcyXXGqEi5E=  ;
Message-ID: <20060121014647.74327.qmail@web34107.mail.mud.yahoo.com>
Date: Fri, 20 Jan 2006 17:46:47 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: set_bit() is broken on i386?
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up to my previous post... this only works if the ADDR macro is not used:
        "+m" (*addr)

What is the purpose of the ADDR macro? (besides calling upon the wrath of the undefined behavior
gremlins?)

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
