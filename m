Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288537AbSAHW5S>; Tue, 8 Jan 2002 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288538AbSAHW5H>; Tue, 8 Jan 2002 17:57:07 -0500
Received: from mxzilla3.xs4all.nl ([194.109.6.49]:6673 "EHLO
	mxzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288537AbSAHW4z>; Tue, 8 Jan 2002 17:56:55 -0500
Date: Tue, 8 Jan 2002 23:56:49 +0100
From: jtv <jtv@xs4all.nl>
To: Greg KH <greg@kroah.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020108235649.A26154@xs4all.nl>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020108220149.GA15816@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 02:01:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 02:01:50PM -0800, Greg KH wrote:
> 
> Can you point me to the place in the spec this is defined?  I don't see
> __FUNCTION__ defined anywhere in the ISO/IEC 9899:1999 (the official C99)
> specification.

Don't have a C99 spec, but here's what info gcc has to say about it:

[...description of "function names" extension as currently found in gcc...]

   Note that these semantics are deprecated, and that GCC 3.2 will
handle `__FUNCTION__' and `__PRETTY_FUNCTION__' the same way as
`__func__'.  `__func__' is defined by the ISO standard C99:

     The identifier `__func__' is implicitly declared by the translator
     as if, immediately following the opening brace of each function
     definition, the declaration
          static const char __func__[] = "function-name";
     
     appeared, where function-name is the name of the lexically-enclosing
     function.  This name is the unadorned name of the function.


Jeroen

