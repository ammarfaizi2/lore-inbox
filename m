Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbTANSva>; Tue, 14 Jan 2003 13:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbTANSv3>; Tue, 14 Jan 2003 13:51:29 -0500
Received: from [66.70.28.20] ([66.70.28.20]:23051 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264972AbTANSv3>; Tue, 14 Jan 2003 13:51:29 -0500
Date: Tue, 14 Jan 2003 19:59:34 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Changing argv[0] under Linux.
Message-ID: <20030114185934.GA49@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I'm not sure whether this issue belongs to the kernel or to the
libc, but I think that is more on the kernel side, that's why I ask
here.

    Let's go to the matter: I want to change the argv[0] a program
shows, in order to be pretty-printed when issuing 'ps', 'top' or
other commands. What I'm doing now is just writing over the existing
argv[0] string, but then I must use a *shorter-or-equal* string in
order to fit it on the existing space. What if I need to put a
*larger* string on argv[0]? Is this possible at all?

    Thanks in advance :)
    Raúl
