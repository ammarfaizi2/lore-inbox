Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbSJOSMc>; Tue, 15 Oct 2002 14:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSJOSM2>; Tue, 15 Oct 2002 14:12:28 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55300 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264937AbSJOSMU>;
	Tue, 15 Oct 2002 14:12:20 -0400
Date: Tue, 15 Oct 2002 20:16:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: JBD Documentation added in BK-current
Message-ID: <20021015201648.A3462@mars.ravnborg.org>
Mail-Followup-To: Roger Gammans <roger@computer-surgery.co.uk>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
References: <20021008212310.A13265@mars.ravnborg.org> <20021014230314.A19801@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014230314.A19801@computer-surgery.co.uk>; from roger@computer-surgery.co.uk on Mon, Oct 14, 2002 at 11:03:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:03:15PM +0100, Roger Gammans wrote:
> 
> Well. I'm not surprised there are a few I couldn't find an SGML reference
> for the linuxdoc dtd , or a tutorial when I wrote it, so I guessed by looking
> at other documents and source code. 
> 
> > [I'm cleaning up the mess in the Makefile after JBD was added right now].
> 
> Did I really make it that messy?
The infrastructure in the docbook makefile has changed since 2.4.

Took a look in the journal-api.sgml file, based on the comments you gave.
I had to do a little more to crete .html without warnings.
I've submitted this to Linus and trivial.. as well.

Browsing the resulting file I wonder why there are references to several
jbd files, but they do not include docgen comments.
Are there some patches missing in 2.5 that updates the comments?

	Sam

===== Documentation/DocBook/journal-api.tmpl 1.1 vs edited =====
--- 1.1/Documentation/DocBook/journal-api.tmpl	Mon Oct  7 16:36:06 2002
+++ edited/Documentation/DocBook/journal-api.tmpl	Tue Oct 15 20:06:15 2002
@@ -208,7 +208,7 @@
 if you allow unprivileged userspace to trigger codepaths containing these
 calls.
 
-<para>
+</para>
 </sect1>
 <sect1>
 <title>Summary</title>
@@ -244,7 +244,8 @@
    }
    journal_destroy(my_jrnl);
 </programlisting>
-
+</para>
+</sect1>
 </chapter>
 
   <chapter id="adt">


