Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVAOESZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVAOESZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVAOESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:18:25 -0500
Received: from opersys.com ([64.40.108.71]:52745 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262094AbVAOESP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:18:15 -0500
Message-ID: <41E89B3E.3090300@opersys.com>
Date: Fri, 14 Jan 2005 23:25:34 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev <ltt-dev@shafik.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <41E84E9E.1000907@am.sony.com>
In-Reply-To: <41E84E9E.1000907@am.sony.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Bird wrote:
> Some of these options (e.g. bufsize) are available to the user
> via tracedaemon. I can honestly say I haven't got a clue what
> to use for some of them, and so always leave them at defaults.

Yes, but those defaults were chosen by a person who understood the
kernel part's use of the buffer space, right? Presumably if you
are writing your own relayfs client you know what type of
throughput to expect and what size you'd like your buffers to
be (bufsize and nbufs), so you need to be able to set this somehow
and it only seems right that this be done upon instantiation.

> Could these be simplified to a few enumerated modes?

I don't see how. Do you have actual examples?

As for the other fields, please see my response to Roman.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
