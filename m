Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315910AbSENRWy>; Tue, 14 May 2002 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315911AbSENRWx>; Tue, 14 May 2002 13:22:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15091 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315910AbSENRWw>; Tue, 14 May 2002 13:22:52 -0400
Date: Tue, 14 May 2002 11:19:26 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <37930000.1021400366@flay>
In-Reply-To: <Pine.LNX.4.44L.0205141335080.9490-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This appears to be global across all cpu's. Maybe nr_iowait_tasks
>> should be accounted on a per-cpu basis, where
> 
> While your proposal should work, somehow I doubt it's worth
> the complexity. It's just a statistic to help sysadmins ;)

Depends how often you're going to end up bouncing that cacheline 
around ... do you do this for every IO?

M.

