Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSHEKLa>; Mon, 5 Aug 2002 06:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSHEKLa>; Mon, 5 Aug 2002 06:11:30 -0400
Received: from ns.suse.de ([213.95.15.193]:38671 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318365AbSHEKL2>;
	Mon, 5 Aug 2002 06:11:28 -0400
To: Anthony Campbell <ac@acampbell.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xconfig and menuconfig no longer work
References: <20020805095157.GA8609@localhost.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Aug 2002 12:15:03 +0200
In-Reply-To: Anthony Campbell's message of "5 Aug 2002 11:55:15 +0200"
Message-ID: <p7365ypk3x4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Campbell <ac@acampbell.org.uk> writes:
> 
> Any suggestions gratefully received; please reply by email as I am not
> on the list at present.

Try find | xargs chmod u+w in the source directory. The bitkeeper
generated tarballs follow the old SCCS cheekiness of disallowing the user
to write his own files/directories by default.

-Andi
