Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284526AbRLJWvv>; Mon, 10 Dec 2001 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284529AbRLJWvl>; Mon, 10 Dec 2001 17:51:41 -0500
Received: from waste.org ([209.173.204.2]:40678 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S284526AbRLJWv1>;
	Mon, 10 Dec 2001 17:51:27 -0500
Date: Mon, 10 Dec 2001 16:50:53 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre8
In-Reply-To: <Pine.LNX.4.21.0112101807381.25397-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.40.0112101640000.10405-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Marcelo Tosatti wrote:

> Here goes pre8: The next one is going to be -rc1 so please don't send me
> any more updates and only bugfixes now.

I'd like to suggest again having patches include change logs. The basic
idea is for a patch to contain a file like patch.foo in the top-level that
includes the changelog entry and the maintainer runs a release script that
build a changelog by concatenating all the patch.* files and then
either appending them to an actual ChangeLog (preferred) or deleting
them. This would make it much easier for people to know the details of
what got fixed without further burdening The Maintainer.

One way to get this started would be to gather up all the existing
change logs, add them to a ChangeLog file, and add a note about the file
being auto-generated.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

