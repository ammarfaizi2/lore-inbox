Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUJ0N2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUJ0N2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUJ0N2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:28:07 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:15372 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S262404AbUJ0N1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:27:39 -0400
Message-ID: <9550.212.241.49.39.1098883651.squirrel@webmail.xs4all.nl>
Date: Wed, 27 Oct 2004 15:27:31 +0200 (CEST)
Subject: Re: Cryptoloop patch for builtin default passphrase
From: "Nico Augustijn" <kernel@janestarz.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: hvr@gnu.org, clemens@endorphin.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:17:53AM +0200, Jan Engelhardt wrote:
> >This here patch will make the kernel use a default passphrase (compiled
into
> >the kernel or cryptoloop.ko module) when you set up a cryptoloop device
with:
>
> Suppose I break in via ssh:
> I could load the module (if applicable), and find the address of the
> function or variable in System.map, extract the static passphrase, and
> well. Then?

Ahem.
The point you are making is rather moot. Because if you manage to get a
shell on the system, the data can readily be copied because the encrypted
filesystem is supposed to be mounted.
Unless I miss your point.

And once you are in the system there are easier ways to obtain the
passphrase than the one you described above. As I clearly stated earlier,
it is merely more difficult to obtain the encrypted data. It is _not_
impossible. It took me approximately 4 hours to break into the system
myself. I bet there's people around who can do it in less than 1 hour.

Some of you might then ask: "What's the point of it then anyway?"
Well, I am probably capable of creating a much better solution with almost
unbreakable encryption. My boss just won't allow me the time for this.
This patch took me about a day to write. It's the best I could come up
with in such a short time.


Nico Augustijn.

[remainder of message deleted]
