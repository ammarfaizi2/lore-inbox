Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288548AbSADIoH>; Fri, 4 Jan 2002 03:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288551AbSADIn6>; Fri, 4 Jan 2002 03:43:58 -0500
Received: from t2.redhat.com ([199.183.24.243]:16638 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S288550AbSADIno>;
	Fri, 4 Jan 2002 03:43:44 -0500
Date: Fri, 4 Jan 2002 00:42:46 -0800
From: Richard Henderson <rth@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Tom Rini <trini@kernel.crashing.org>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020104004246.A14441@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Pavel Machek <pavel@suse.cz>, Tom Rini <trini@kernel.crashing.org>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102142712.B10474@redhat.com> <20020103234046.B12380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103234046.B12380@elf.ucw.cz>; from pavel@suse.cz on Thu, Jan 03, 2002 at 11:40:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 11:40:46PM +0100, Pavel Machek wrote:
> Is there problem with doing what Jakub suggested?

No, but I think it better to extract all of the relocation up front
rather than scattering it about the source code.



r~
