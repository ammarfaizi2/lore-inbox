Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSFEWrL>; Wed, 5 Jun 2002 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSFEWrK>; Wed, 5 Jun 2002 18:47:10 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:43524 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316512AbSFEWrK>;
	Wed, 5 Jun 2002 18:47:10 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 5 Jun 2002 16:39:27 -0600
To: Padraig Brady <padraig@antefacto.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605163927.P13197@host110.fsmlabs.com>
In-Reply-To: <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <3CFDEA79.2980BF8D@zip.com.au> <3CFE5A50.9010002@mandrakesoft.com> <3CFE9181.7090603@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that this level of abstraction is the kernel's job.  Deciding this
sort of thing is best left for a user level tool (or the user with 'echo').
A generic set of tunables in /proc/sys/ makes sense, but deciding the best
policy for a given set of parameters is a big problem and would be best
solved outside of the kernel.

This is definitely the sort of thing that can be pushed to the user and
should be.

} I'm not too sure this level of abstraction is needed by userspace.
} It would be enough if the appropriate things were all controlable
} in /proc/sys/ etc. and then you just have:
} /etc/sysctl.{laptop,server,desktop}.conf
} It would be better to have it explicit in userspace as you're
} always going to need to tweak things IMHO.
} 
} Padraig.
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
