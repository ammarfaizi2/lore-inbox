Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbSJDWgS>; Fri, 4 Oct 2002 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbSJDWgS>; Fri, 4 Oct 2002 18:36:18 -0400
Received: from gw.openss7.com ([142.179.199.224]:14852 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262027AbSJDWgS>;
	Fri, 4 Oct 2002 18:36:18 -0400
Date: Fri, 4 Oct 2002 16:41:51 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, ak@suse.de, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004164151.D2962@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	alan@lxorguk.ukuu.org.uk, ak@suse.de, zaitcev@redhat.com,
	linux-kernel@vger.kernel.org
References: <p73fzvmqdg4.fsf@oldwotan.suse.de> <1033757193.31839.51.camel@irongate.swansea.linux.org.uk> <20021004131547.B2369@openss7.org> <20021004.152116.116611188.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004.152116.116611188.davem@redhat.com>; from davem@redhat.com on Fri, Oct 04, 2002 at 03:21:16PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Fri, 04 Oct 2002, David S. Miller wrote:
> 
> The sparc64 changes are absolutely wrong, the syscalls take pointers
> and thus must go through a 32-bit ABI to 64-bit ABI syscall
> translation routine.
> 

Do you mean a sys32_*_wrapper ?  Would you please offer up those
five lines of code?

--brian
