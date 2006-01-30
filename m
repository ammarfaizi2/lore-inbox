Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWA3L0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWA3L0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWA3L0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:26:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19860 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932219AbWA3L0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:26:23 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 12:25:05 +0100
To: schilling@fokus.fraunhofer.de, James@superbug.co.uk
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DDF791.nail16Z21590B@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
In-Reply-To: <43DA4DDA.7070509@superbug.co.uk>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.co.uk> wrote:

> Would you be able to add the appropriate kernel bugzilla numbers?

As before people from LKML did not like to even talk about these bugs, 
I did stop after sending bug reports to LKML.

> I think it might also be useful to make a list of all the SCSI commands 
> that cdrecord uses. Including all the vendor specific ones. One could 
> then verify that the Linux kernel is passing them onto the device correctly.


It is simple to find the SCSI commands that cdrecord by scanning the source (*),
but this is something that is subject to frequent change in case cdrecord needs
to add new MMC-4711 commands or in case that I need to add a new vendor unique
command in order to support special features.


*) Just grep for "cdb.cmd"


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
