Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDQO4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTDQO4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:56:04 -0400
Received: from grieg.holmsjoen.com ([206.124.139.154]:11021 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP id S261521AbTDQO4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:56:02 -0400
Date: Thu, 17 Apr 2003 08:07:54 -0700
From: Randolph Bentson <bentson@grieg.holmsjoen.com>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-English user messages
Message-ID: <20030417080754.A32133@grieg.holmsjoen.com>
References: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com> <200304141645.48020.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304141645.48020.EricAltendorf@orst.edu>; from EricAltendorf@orst.edu on Tue, Apr 15, 2003 at 11:02:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 11:02:15AM -0700, Eric Altendorf wrote:
> If you find yourself having to write comments and documentation to 
> explain your code, probably your identifiers are not well named, your 
> functions are not short enough, and your code is not well structured 
> enough.
> 
> Ideal code is completely self-documenting.

That's true if documentation serves only to describe _what_ the
code does.  You've ignored the need to describe _why_ the code
was written in this way.  For example, documentation can note some
feature of the hardware which requires special handling, or it can
describe some emergent property which isn't obvious even if all
the code is understood.

That's why local comments should explain non-obvious trickery used,
perhaps the exploitation of a poorly documented side-effect of some
instruction, and block comments or external documentation should
help the reader understand why things are done some particular way.
For instance, if the code implements some specific, well documented
algorithm, it should reference the algorithm by name.

-- 
Randolph Bentson
bentson@holmsjoen.com
