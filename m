Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUIIR2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUIIR2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUIIRZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:25:52 -0400
Received: from holomorphy.com ([207.189.100.168]:51633 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266457AbUIIRYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:24:05 -0400
Date: Thu, 9 Sep 2004 10:23:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
Message-ID: <20040909172326.GY3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	William Stearns <wstearns@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909090342.GA30303@thunk.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:09:52AM +0200, Robin Rosenberg wrote:
>> Maybe file/./attribute then. /. on a file is currently meaningless.
>> That does not avoid the unpleasant fact that has been brought up by
>> others (only to be ignored), that the directory syntax does not
>> allow metadata on directories.

On Thu, Sep 09, 2004 at 05:03:42AM -0400, Theodore Ts'o wrote:
> *Not* that I am endorsing the idea of being able to access metadata
> via a standard pathname --- I continue to believe that named streams
> are a bad idea that will be an attractive nuisance to application
> developers, and if we must do them, then Solaris's openat(2) API is
> the best way to proceed --- HOWEVER, if people are insistent on being
> able to do this via standard pathnames, and not introducing a new
> system call, I would suggest /|/ as the separator as the third least
> worst option.  Why?

I believe this debate is counterproductive while there are far more
basic and serious issues with reiser4, such as architecture-neutrality
of the interpretation of the on-disk format, still pending.


-- wli
