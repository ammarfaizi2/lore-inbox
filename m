Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUHIMFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUHIMFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHIMFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:05:39 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29104 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266505AbUHIMEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:04:31 -0400
X-Sender-Authentication: net64
Date: Mon, 9 Aug 2004 14:04:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040809140426.142dc4eb.skraw@ithnet.com>
In-Reply-To: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 12:13:26 +0200 (CEST)
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> If you like to call the Sun developers and the FreeBSD developers (which
> means people like Bill Joy and Scott Mcusick) stupid, you seem to have a real
> strange idea from the world :-(

Please stop throwing names as supporters into the ring that very likely are not
listening! This is pretty bad style...
 
> AGAIN: if you believe you did invent a better method, _describe_ it.
> As you did not describe a _working_ method different from the one I request,
> you need to agree that you are wrong - as long as your description is
> missing.

You obviously did not get the basics of the whole story, did you? I really
wonder how you came this far.
_You_ are writing code that should be - according to _your_ idea - platform
independent. If you do something like this it is most obvious that your code
falls mainly into two pieces: 
a) platform-independent code
b) glue code to the specific host/platform
You have full control over a) and certain unbreakable external requirements for
b).
Listening to your posts makes me wonder what your intention really is. Linux
should be only another host/platform for a new set of glue code, but it seems
you are unable to produce a working code. Instead of listening to people
_knowing_ the platform _you_ tell _them_ how they should change their code to
match your ideas.
You definitely should give a damn about the platform being well-designed or
worse, the only really interesting thing for you should be how to fit into it.
If you did it right glueing should only be about 5-10% of your whole code.
And you should be able to specify some interface for people writing glue code
for your application.
Neither you do. So what do you want _at all_ ??

Understand this: _nobody_ expects you to know everything about 25 different
OS's, the only thing that can be expected is that you simply listen to the
different parties knowing the different platforms and _take their advice_,
really not more.

Please stop being blinded by your very own glory...
People are only trying to help you.

Regards,
Stephan
(written portable driver code for: AmigaOS, DOS, Linux, Netware 3.X, 4.X,
Some Unix's, Windows 3.X, NT4, XP)

