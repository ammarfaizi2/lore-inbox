Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131873AbRC1PFw>; Wed, 28 Mar 2001 10:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131836AbRC1PFn>; Wed, 28 Mar 2001 10:05:43 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:43925 "EHLO zalem.puupuu.org") by vger.kernel.org with ESMTP id <S131888AbRC1PFc>; Wed, 28 Mar 2001 10:05:32 -0500
Date: Wed, 28 Mar 2001 10:04:40 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328100440.A5941@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes> <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk>; from announce@sis-domain.demon.co.uk on Wed, Mar 28, 2001 at 03:04:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 03:04:46PM +0100, Simon Williams wrote:
> I think their point was that a program could only change permissions
> of a file that was owned by the same owner.  If a file is owned by a
> different user & has no write permissions for any user, the program
> can't modify the file or it's permissions.

You mean, you usually have write permissions for other than the owner
on executable files?

Let me reformulate that.  You usually have write permissions for other
than the owner, and not only on some special, untrusted log files (I'm
talking files, here, not device nodes)?  What's your umask, 0?


> Sounds like a good plan to me.

PEBCAK.  Unix security is not designed with dumb "administrators" in
mind, nor should be.  User friendly is good.  Luser friendly isn't,
it's either dumbing down or unnecessarily restrictive.

  OG, who waits for the first insmod-ing "virus"
