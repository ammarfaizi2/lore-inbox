Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRJDVzZ>; Thu, 4 Oct 2001 17:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277245AbRJDVzF>; Thu, 4 Oct 2001 17:55:05 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44436 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277244AbRJDVy5>; Thu, 4 Oct 2001 17:54:57 -0400
Date: Thu, 4 Oct 2001 17:55:26 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rgooch@ras.ucalgary.ca, arjan@fenrus.demon.nl, kravetz@us.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011004175526.C18528@redhat.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <20011004.142523.54186018.davem@redhat.com> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011004.145239.62666846.davem@redhat.com>; from davem@redhat.com on Thu, Oct 04, 2001 at 02:52:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 02:52:39PM -0700, David S. Miller wrote:
> So the FPU hit is only before/after the runs, not during each and
> every iteration.

Right.  Plus, the original mail mentioned that it was hitting all 8 
CPUs, which is a pretty good example of braindead scheduler behaviour.

		-ben
