Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVAIV0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVAIV0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVAIV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:26:55 -0500
Received: from manson.clss.net ([65.211.158.2]:10947 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S261820AbVAIVYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:24:47 -0500
Message-ID: <20050109212446.23575.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: printf() overhead
To: nigelenki@comcast.net (John Richard Moser)
Date: Sun, 9 Jan 2005 16:24:46 -0500 (EST)
Cc: andre@tomt.net (Andre Tomt), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "John Richard Moser" at Jan 09, 2005 04:16:17 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser writes the following:
>Andre Tomt wrote:
>| John Richard Moser wrote:
>|> using strace to run a program takes aeons.  Redirecting the output to a
>|> file can be a hundred times faster sometimes.  This raises question.
>|
>| The terminal is a major factor; gnome-terminal for example can be
>| *extremely* slow.
>|
>
>Is there a way to give the data to the terminal and let the program go
>while that happens?  Or is there an execution path (i.e. terminal says
>"WTF NO") that can be missed that way?

strace -o tracefile prog & tail -n +1 -f tracefile

