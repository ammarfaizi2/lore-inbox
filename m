Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSKOKwv>; Fri, 15 Nov 2002 05:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266106AbSKOKwv>; Fri, 15 Nov 2002 05:52:51 -0500
Received: from smtp.comcast.net ([24.153.64.2]:42994 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S266094AbSKOKwt>;
	Fri, 15 Nov 2002 05:52:49 -0500
Date: Fri, 15 Nov 2002 05:58:27 -0500
From: FZiegler <hysterion@mac.com>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
In-reply-to: <fa.i6a51vv.5s3if@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Message-id: <3DD4D353.5000500@mac.com>
Organization: none
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.2b)
 Gecko/20021107
References: <fa.cg3ae9v.ji8118@ifi.uio.no> <fa.i6a51vv.5s3if@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Northup wrote:

>>things in major trees like -mm,
>>-ac, -dj etc are likely going to end up in mainline sooner or later
>>anyway ... wouldn't you rather know of the breakage sooner rather
>>than later?
> 
> 
> Would this be an appropriate use of the "version" tag in Bugzilla?  Currently 
> the only choice is "2.5", but if that were renamed to "2.5-linus", then the 
> other heavily used patchsets could be monitored while making it easy for 
> people who only want to see bugs in Linus' tree.



Analogous though slightly different suggestion: have a "Tree" column
just where Mozilla have their (quite analogous) "OpSys" field. Compare

       http://bugme.osdl.org/queryhelp.cgi#bugsettings
       http://bugzilla.mozilla.org/queryhelp.cgi#bugsettings

This way people can set their queries, and triagers manage triage, in
such a way that nothing shows on anyone's radar until it's actually
relevant to them. (Whether a tree appears in the list would be up to its
maintainer, I guess.)

Caveat: although *queries* for (say) "-ac OR -dj" are possible, the
fields themselves are still single-valued. So there ought to be an
agreement that a bug doesn't get promoted to "All" trees just because
it's been confirmed on more than one.

(This has been a recurring problem in Mozilla -- e.g. people have tended
to flag PPC bugs against "All" OSes when they only meant Apple OSes, not
NetBSD or Linux PPC. Multi-valuedness would be the clean solution but
unfortunately, afaik, Bugzilla doesn't support it for those fields.)





