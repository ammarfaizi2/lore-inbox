Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTAIJvE>; Thu, 9 Jan 2003 04:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTAIJvE>; Thu, 9 Jan 2003 04:51:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62985 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265806AbTAIJvD>; Thu, 9 Jan 2003 04:51:03 -0500
Message-ID: <3E1D4837.7558538B@aitel.hist.no>
Date: Thu, 09 Jan 2003 11:00:23 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Sven Luther <luther@dpt-info.u-strasbg.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: rotation.
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org> <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be> <20030108104817.GA10165@iliana>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther wrote:

> 
> So, we also support fbcon for not left to righ locales ?
This looks like a high-level thing to me.
Ideally something like ansi escape sequences to switch between
left-to-right, right-to-left, and up-to-down advancing of
the cursor.  Then the same multilingual apps will work with
fbdev, xterm, and other terminals and emulators that
implement those operations.

Helge Hafting
