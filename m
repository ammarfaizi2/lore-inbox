Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262951AbTDBJYN>; Wed, 2 Apr 2003 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262952AbTDBJYN>; Wed, 2 Apr 2003 04:24:13 -0500
Received: from cpe-024-033-021-148.midsouth.rr.com ([24.33.21.148]:5248 "EHLO
	braindead") by vger.kernel.org with ESMTP id <S262951AbTDBJYM>;
	Wed, 2 Apr 2003 04:24:12 -0500
From: Warren Turkal <wturkal@cbu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] laptop keyboard, tracked to ACPI
Date: Wed, 2 Apr 2003 03:35:02 -0600
User-Agent: KMail/1.5.1
References: <F760B14C9561B941B89469F59BA3A847E96D93@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D93@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304020335.03120.wturkal@cbu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 March 2003 12:09 pm, Grover, Andrew wrote:
> > From: Warren Turkal [mailto:wturkal@cbu.edu]
> > Andy Grover, ACPI Maintainer, I am CCing you directly as I
> > think this is your
> > bug at this point. When I compile a kernel without ACPI, the
> > bug does not
> > show its face. When I compile with ACPI in modules and load
> > none of the
> > modules, the bug still happens. I think that the bug exists
> > in the base ACPI
> > support code as a result. The bug is described below. I have
> > not tried the
> > latest linus bk patches. This current round of tests was
> > performed on 2.5.66.
> > 2.5.63 is the last version of the kernel that does not have this bug.
>
> Please try the ACPI patch from http://sf.net/projects/acpi and let me
> know if it doesn't fix things.
>
> Thanks -- Regards -- Andy

This does fix it. Thanks so much! :-D Now I just wonder if that OOPS on 
shutdown is fixed yet.

Warren
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

