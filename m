Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSJaQeJ>; Thu, 31 Oct 2002 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJaQdB>; Thu, 31 Oct 2002 11:33:01 -0500
Received: from [216.239.30.242] ([216.239.30.242]:1286 "EHLO wind.enjellic.com")
	by vger.kernel.org with ESMTP id <S263252AbSJaQcu>;
	Thu, 31 Oct 2002 11:32:50 -0500
Message-Id: <200210311639.g9VGd33H024723@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Thu, 31 Oct 2002 10:39:03 -0600
In-Reply-To: Linus Torvalds <torvalds@transmeta.com>
       "Re: What's left over." (Oct 30,  6:31pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: What's left over.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30,  6:31pm, Linus Torvalds wrote:
} Subject: Re: What's left over.

> > ext2/ext3 ACLs and Extended Attributes
>
> I don't know why people still want ACL's. There were noises about
> them for samba, but I'v enot heard anything since. Are vendors using
> this?

I can offer a perspective from someone who has been struggling to get
Linux competitive in real-life enterprise situations.

ACL's are an issue for Linux (and Samba) in order for the combination
to sustain competitiveness against Novell and NT in the desktop
fileservices domain.  The harsh reality of life is that file and
document sharing is a way of life in the environments where Novell
dominates.  The appearance of ACL's and desktop support for their
management in NT would tend to confirm this.

Without the granularity of ACL's it becomes too difficult to establish
the types of permission environments needed to support what most
administrative and department support personnel (ie, secretaries) seem
to desire.

The patches also begin implementing a common API framework which
multiple filesystems seem to be able to leverage.  At least the rumor
appears to be that the instrastructure allows common toolsets to be
used for both ext2/3, XFS and perhaps other filesystems which want to
implement ACL's.

Its a compilation option and if set to default minimizes the impact on
people who don't need or want the infrastructure.  Ted also has his
fingers in the project which probably means that it isn't going to get
neglected.

Just my 2 cents.

Best wishes for a productive weekend to everyone.

Greg

}-- End of excerpt from Linus Torvalds

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Open source code is not guaranteed nor does it come with a warranty."
                                -- the Alexis de Tocqueville Institute

"I guess that's in contrast to proprietary software, which comes with
 a money-back guarantee, and free on-site repairs if any bugs are found."
                                -- Rary
