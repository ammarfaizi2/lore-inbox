Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVDTMua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDTMua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVDTMua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:50:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:966 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261578AbVDTMuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:50:22 -0400
Subject: Re: GPL violation by CorAccess?
From: Steven Rostedt <rostedt@goodmis.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel@vger.kernel.org, Karel Kulhavy <clock@twibright.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-os@analogic.com,
       Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <1113982209.3803.7.camel@gimli.at.home>
References: <20050419175743.GA8339@beton.cybernet.src>
	 <20050419182529.GT17865@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
	 <42656319.6090703@nortel.com>
	 <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
	 <42659620.5050002@nortel.com>  <1113982209.3803.7.camel@gimli.at.home>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 20 Apr 2005 08:49:58 -0400
Message-Id: <1114001398.774.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 09:30 +0200, Bernd Petrovitsch wrote:

> 
> As long as they do not statically link against LGPL (or GPL) code and as
> long as they do not link dynamically agaist GPL code. And there are
> probably more rules .....
> 

Actually, I believe that the LGPL allows for static linking as well. As
long as you only interact with the library through the defined API, it
is OK.

>From the LGPL preamble:

 The precise terms and conditions for copying, distribution and
modification follow.  Pay close attention to the difference between a
"work based on the library" and a "work that uses the library".  The
former contains code derived from the library, whereas the latter must
be combined with the library in order to run.


Point number 5 of TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION:

 5. A program that contains no derivative of any portion of the
Library, but is designed to work with the Library by being compiled or
linked with it, is called a "work that uses the Library".  Such a
work, in isolation, is not a derivative work of the Library, and
therefore falls outside the scope of this License.


So, I would say that the LGPL _does_ allow statically linked to non GPL
work.


-- Steve


