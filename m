Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315844AbSENQzt>; Tue, 14 May 2002 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315872AbSENQzs>; Tue, 14 May 2002 12:55:48 -0400
Received: from holomorphy.com ([66.224.33.161]:38557 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315844AbSENQzr>;
	Tue, 14 May 2002 12:55:47 -0400
Date: Tue, 14 May 2002 09:54:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020514165414.GC27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <20020514153956.GI15756@holomorphy.com> <Pine.LNX.4.44L.0205141335080.9490-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, William Lee Irwin III wrote:
>> This appears to be global across all cpu's. Maybe nr_iowait_tasks
>> should be accounted on a per-cpu basis, where

On Tue, May 14, 2002 at 01:36:00PM -0300, Rik van Riel wrote:
> While your proposal should work, somehow I doubt it's worth
> the complexity. It's just a statistic to help sysadmins ;)

I reserved judgment on that in order to present a possible mechanism.
I'm not sure it is either; we'll know it matters if sysadmins scream.


Cheers,
Bill
