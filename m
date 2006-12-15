Return-Path: <linux-kernel-owner+w=401wt.eu-S965083AbWLOEyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWLOEyZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 23:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWLOEyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 23:54:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965083AbWLOEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 23:54:24 -0500
To: Greg KH <gregkh@suse.de>
Cc: Michael ODonald <mcodonald@yahoo.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Abolishing the DMCA
References: <561312.27000.qm@web58907.mail.re1.yahoo.com>
	<20061214213246.GB9450@suse.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Fri, 15 Dec 2006 02:53:55 -0200
In-Reply-To: <20061214213246.GB9450@suse.de> (Greg KH's message of "Thu\, 14 Dec 2006 13\:32\:46 -0800")
Message-ID: <orslfh3gkc.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2006, Greg KH <gregkh@suse.de> wrote:

> I think you missed the point that my patch prevents valid usages of
> non-GPL modules from happening, which is not acceptable.

What if you changed your patch so as to only permit loading of
possibly-infringing drivers after some flag in /proc is set, and
logging to the console a message explaining (i) why such drivers might
be infringing and how to contact the copyright holders to get the
infringement stopped, and (ii) how to get it loaded if you believe
it's ok.

Then the patch would change from a probably-harmful DRM technique to
an educational tool, that wouldn't impose any major inconvenience to
those who are entitled to use the combination of code that can't be
distributed.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
