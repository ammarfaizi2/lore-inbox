Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbTIWTHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIWTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:07:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53643
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262197AbTIWTG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:06:57 -0400
Date: Tue, 23 Sep 2003 21:06:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matt Heler <lkml@lpbproductions.com>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Subject: offtopic (Re: Horiffic SPAM)
Message-ID: <20030923190656.GF1269@velociraptor.random>
References: <Pine.LNX.4.53.0309231408260.28457@quark.analogic.com> <20030923183648.GE1269@velociraptor.random> <200309231153.09298.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309231153.09298.lkml@lpbproductions.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:53:04AM -0700, Matt Heler wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ive been living in a mail hole theese past few years.. Where does one get this 
> baesyan algorithm ?? 

www.spamassassin.org

~/bin/Mail-SpamAssassin-2.60/sa-learn --mbox --spam ~/mail/spam
~/bin/Mail-SpamAssassin-2.60/sa-learn --mbox --spam ~/mail/spam-bad

spam-bad is differentiated because it gets >15 marks, so it gets deleted
immediatly after learning. (see the docs in the package)

but make sure to teach the baesyan about your regular email first, the
number of "ham" must be >= "spam" or your risk losing legitmate email. I
use my inbox as "ham" (that's around 10000 messages).

this is the status of my db

0.000          0        688          0  non-token data: nspam
0.000          0       9722          0  non-token data: nham

see now what it returns for these >100k viruses (Bayesian spam
probability is 99 to 100%)

-------- cut and paste begin ---------
 pts rule name              description
---- ---------------------- --------------------------------------------------
 0.1 HTML_MESSAGE           BODY: HTML included in message
 1.7 HTML_RELAYING_FRAME    BODY: Frame wanted to load outside URL
 5.4 BAYES_99               BODY: Bayesian spam probability is 99 to 100%
                            [score: 1.0000]
 0.3 MIME_HTML_ONLY         BODY: Message only has text/html MIME parts
 0.1 HTML_50_60             BODY: Message is 50% to 60% HTML
 5.6 IFRAME                 BODY: IFRAME virus
 3.0 MICROSOFT_EXECUTABLE   RAW: Message includes Microsoft executable program
 0.6 MIME_HTML_NO_CHARSET   RAW: Message text in HTML without charset
 0.1 MIME_SUSPECT_NAME      RAW: MIME filename does not match content
 1.1 MIME_HTML_ONLY_MULTI   Multipart message only has text/html MIME parts

The original message was not completely plain text, and may be unsafe to
open with some email clients; in particular, it may contain a virus,
or confirm that your address can receive spam.  If you wish to view
it, it may be safer to save it to a file and open it with an editor.


[-- Attachment #2: original message before SpamAssassin --]
[-- Type: message/rfc822, Encoding: 8bit, Size: 142K --]

Date: Tue, 23 Sep 2003 13:30:38 -0500
From: "microsoft net message system" <mailerrobot@america.com>
To: "network recipient" <client@yourdomain.com>
SUBJECT: Bug Advice
X-Virus-Information: Please visit http://enap.wt.net for more
information
X-Virus-Scanner: Found to be clean

[-- Autoview using lynx -dump '/tmp/mutt.html' --]

   IFRAME: [1]cid:mccexrrgkte

   Hi.
   Undeliverable to mxwxeztble@america.com
[..]
-------- cut and paste end ---------

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
