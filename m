Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVACBXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVACBXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVACBXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:23:17 -0500
Received: from holomorphy.com ([207.189.100.168]:19863 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261377AbVACBW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:22:56 -0500
Date: Sun, 2 Jan 2005 17:19:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: William Lee Irwin III <wli@debian.org>, Bill Davidsen <davidsen@tmr.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103011935.GQ29332@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103004551.GK4183@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 04:30:11PM -0800, William Lee Irwin III wrote:
>> The presumption is that these changes are frivolous. This is false.
>> The removals of these features are motivated by their unsoundness,
>> and those removals resolve real problems. If they did not do so, they
>> would not pass peer review.

On Mon, Jan 03, 2005 at 01:45:51AM +0100, Adrian Bunk wrote:
> The netfilter people plan to remove ipfwadm and ipchains before 2.6.11 .
> This is legacy code that makes their development sometimes a bit harder, 
> but AFAIK ipchains in 2.6.10 doesn't suffer from any serious real 
> problems.

They're superseded by iptables and their sole uses are by the Linux-
specific applications to manipulate this privileged aspect of system
state. This makes a much weaker case for backward compatibility than
general nonprivileged standardized system calls.


On Sun, Jan 02, 2005 at 04:30:11PM -0800, William Lee Irwin III wrote:
>> I can't speak for anyone during the times of more ancient Linux history;
>> however, developers' dissatisfaction with the development model has been
>> aired numerous times in certain fora. It has not satisfactorily served
>> developers or users. Users are locked into distro kernels for
>> incompatible extensions, and developers are torn between multiple
>> codebases.

On Mon, Jan 03, 2005 at 01:45:51AM +0100, Adrian Bunk wrote:
> At least on Debian, ftp.kernel.org kernels work fine.

This does not advance the argument.


On Sun, Jan 02, 2005 at 04:30:11PM -0800, William Lee Irwin III wrote:
>> This fragmentation of programmer effort is trivially recognizable as
>> counterproductive. A single focal point for programmer effort is far
>> superior for a development model. If the standard of stability is not
>> passed then the code is not ready to be included in any kernel. Then
>> the distinction is lost, and each of the fragmented codebases gets a
>> third-class effort, and a spurious expenditure of effort is wasted on
>> porting fixes and features across numerous different codebases.
>>...

On Mon, Jan 03, 2005 at 01:45:51AM +0100, Adrian Bunk wrote:
> My impression is that currently 2.4 doesn't take that much time of 
> developers (except for Marcelo's), and that it's a quite usable and 
> stable kernel.

The ``stable'' moniker and distros being based on 2.4 are horrors
beyond imagination and developers are pushed to in turn push
inappropriate features on 2.4.x and maintain them out-of-tree for
2.4.x


-- wli
