Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSDEKr7>; Fri, 5 Apr 2002 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSDEKrt>; Fri, 5 Apr 2002 05:47:49 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:45952 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312418AbSDEKrm>; Fri, 5 Apr 2002 05:47:42 -0500
Date: Fri, 5 Apr 2002 12:47:33 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405104733.GD16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020405095038.GB16595@come.alcove-fr> <20020405.020443.115246313.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 02:04:43AM -0800, David S. Miller wrote:

>    From: Stelian Pop <stelian.pop@fr.alcove.com>
>    Date: Fri, 5 Apr 2002 11:50:39 +0200
> 
>    	* the client side socket passes in CLOSE-WAIT state
>    	* the client issues a write on the socket which succeds.
>  ...   
>    Attached are sample codes for the "server" and the "client". Test
>    was done on latest 2.4 and 2.5 kernels.
> 
> Your client does not do any write()'s after the shutdown call.
> It simply exit(0)'s.

You mean the 'server' ? Even if I add a sleep(600) between the 
shutdown() call and the exit() call I get the same behaviour.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
