Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWBJQcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWBJQcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWBJQcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:32:32 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:45549 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751290AbWBJQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:32:31 -0500
From: Luke-Jr <luke@dashjr.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 10 Feb 2006 16:32:19 +0000
User-Agent: KMail/1.9
Cc: mrmacman_g4@mac.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner>
In-Reply-To: <43EC83EC.nailISD91HRFF@burner>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101632.24649.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 12:15, Joerg Schilling wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > Joerg Schilling wrote:
> > > -	how to use /dev/hd* in order to scan an image from a scanner
> > > -	how to use /dev/hd* in order to talk to a printer
> > > -	how to use /dev/hd* in order to talk to a jukebox
> > > -	how to use /dev/hd* in order to talk to a graphical device
> >
> > Does cdrecord scan images, print files, or talk to SCSI graphical
>
> Are you _completely_ ingnoring the facts that have been discused here?

Are you completely ignoring that nobody in this thread cares about libscg's 
ability to work with other devices? The problem is in the user-interface, and 
underlying workings is really pretty irrelevant to the matter.

> This does not apply to cdrecord but to libscg.

cdrecord contains the UI, so it is the only program relevant to the problem. 
If libscg is impeding fixing the bug (I don't think it is, but you seem to), 
then maybe cdrecord should use transport.hxx from growisofs.
