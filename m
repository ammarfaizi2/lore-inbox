Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278680AbRJSWM5>; Fri, 19 Oct 2001 18:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278679AbRJSWMr>; Fri, 19 Oct 2001 18:12:47 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44825 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278678AbRJSWMa>; Fri, 19 Oct 2001 18:12:30 -0400
Date: Fri, 19 Oct 2001 18:13:00 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011019181300.I9206@redhat.com>
In-Reply-To: <20011019173055.G9206@redhat.com> <20011019.145639.59667516.davem@redhat.com> <20011019180433.H9206@redhat.com> <20011019.151101.21914602.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011019.151101.21914602.davem@redhat.com>; from davem@redhat.com on Fri, Oct 19, 2001 at 03:11:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 03:11:01PM -0700, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Fri, 19 Oct 2001 18:04:34 -0400
>    
>    If the hash table was grown dynamically, I wouldn't have this complaint.
>    
> It's too expensive to implement.  It adds a new check every
> connection, _or_ some timer which periodically scans the chain
> lengths.

Then make it a sysctl.  Sysadmins exist for a reason. ;-)

		-ben
