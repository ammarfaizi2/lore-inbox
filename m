Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUIWRfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUIWRfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIWReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:34:04 -0400
Received: from holomorphy.com ([207.189.100.168]:16088 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268162AbUIWRdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:33:24 -0400
Date: Thu, 23 Sep 2004 10:33:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923173315.GG9106@holomorphy.com>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com> <20040923172104.GN23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923172104.GN23987@parcelfarce.linux.theplanet.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
>> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
>> will cause spurious ignorance of the remainder of the line, which is

On Thu, Sep 23, 2004 at 06:21:04PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Usual Albert's taste level aside, you are wrong.  Comments are replaced
> with whitespace on phase 3 (tokenizer) and preprocessor lives on phase 4.
> IOW, that // will never be seen by preprocessor.

I'll be sure to put this on file with the rest of the numerous "while
legal in C, never *EVER* do this" oddities.


-- wli
