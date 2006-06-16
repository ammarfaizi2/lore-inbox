Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWFPBOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWFPBOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWFPBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 21:14:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:8674 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750931AbWFPBOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 21:14:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENv8IakfR6QzgBDzhGQbIUAQUFC5pK5W3NuZzobJvtM5NJ3sXdAKkA0K+HmCgxnHNasoIT0G1/PkU6MfJ2lo7MBxhgboDz9OtPoRzvJgdbbmLoh9wYwhfS66X8VxmFgWkSlj3ENqpw+L0oMFFg31edA/qhrzAOdl+4g5UhXS2Kw=
Message-ID: <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
Date: Fri, 16 Jun 2006 13:14:09 +1200
From: "Goo GGooo" <googgooo@gmail.com>
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
In-Reply-To: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/06, Goo GGooo <googgooo@gmail.com> wrote:
> Andrew Morton wrote:
>
> > - To fetch an -mm tree using git, use (for example)
> >
> >  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
> > v2.6.16-rc2-mm1
>
> I'm not able to get -mm tree from GIT. In
> http://git.kernel.org/.../smurf/linux-trees.git/refs/tags/ I can see
> the most recent tags like v2.6.17-rc6-mm2 but cg-clone
> http://git.kernel.org/.../smurf/linux-trees.git gives me only
> 2.6.16-rc3 :(
>
> I tried "cg-fetch v2.6.17-rc6-mm2" which seemed to fetch some more
> tags, then played with git-checkout & friends but still can't get the
> most recent source tree.

All right, finally this worked out:
git pull rsync://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git \
      tag v2.6.17-rc6-mm2

Strange enough with http:// instead of rsync:// I got some message
about nonexistent tag.

Now when I try git pull with http:// again it says the tree is up to
date. However with git:// it started downloading more things and tags.

That's confusing - I believed all protocols should behave the same way...?

Goo
