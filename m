Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCHRUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCHRUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVCHRUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:20:02 -0500
Received: from sta.galis.org ([66.250.170.210]:59016 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S261423AbVCHRTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:19:54 -0500
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
  users@spamassassin.apache.org,
  misc@list.smarden.org,
  supervision@list.skarnet.org,
  nix@esperi.org.uk,
  mkettler@evi-inc.com
Date: Tue, 8 Mar 2005 12:19:53 -0500
To: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
       misc@list.smarden.org, supervision@list.skarnet.org, nix@esperi.org.uk,
       mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
Message-ID: <20050308171953.GB1936@ixeon.local>
References: <20050303214023.GD1251@ixeon.local> <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2> <20050303224616.GA1428@ixeon.local> <871xaqb6o0.fsf@amaterasu.srvr.nix> <20050308165814.GA1936@ixeon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308165814.GA1936@ixeon.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 11:58:14AM -0500, George Georgalis wrote:
>On Tue, Mar 08, 2005 at 01:37:03PM +0000, Nix wrote:
>>On Thu, 3 Mar 2005, George Georgalis uttered the following:
>>> I recall a problem a while back with a pipe from
>>> /proc/kmsg that was sent by root to a program with a
>>> user uid. The fix was to run the logging program as
>>> root. Has that protected pipe method been extended
>>> since 2.6.8.1?
>>
>>The entire implementation of pipes has been radically revised between
>>2.6.10 and 2.6.11: see, e.g., <http://lwn.net/Articles/118750/> and
>><http://lwn.net/Articles/119682/>.
>>
>>Bugs have been spotted in this area in 2.6.10: this may be
>>another one.
>
>Thanks, my issue is clearly between 2.6.10 and 2.6.11; though I won't be
>able to drill down anything more specific, for a while. The links
>do look relevant but I cannot say for sure.

My last post didn't actually describe what the problem is, which is
spamassassin always scores 0/0 under 2.6.11 but functions properly
(scoring x/5) under 2.6.10.

More details are in the thread of this post.
http://lkml.org/lkml/2005/3/3/513

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
