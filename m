Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287530AbSAHBDN>; Mon, 7 Jan 2002 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287521AbSAHBDE>; Mon, 7 Jan 2002 20:03:04 -0500
Received: from dot.cygnus.com ([205.180.230.224]:1037 "HELO dot.cygnus.com")
	by vger.kernel.org with SMTP id <S287530AbSAHBCs>;
	Mon, 7 Jan 2002 20:02:48 -0500
Date: Mon, 7 Jan 2002 17:02:18 -0800
From: Richard Henderson <rth@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: mike stump <mrs@windriver.com>, gdr@codesourcery.com, dewar@gnat.com,
        gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107170218.A25070@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Paul Mackerras <paulus@samba.org>, mike stump <mrs@windriver.com>,
	gdr@codesourcery.com, dewar@gnat.com, gcc@gcc.gnu.org,
	linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
	velco@fadata.bg
In-Reply-To: <200201071936.LAA12038@kankakee.wrs.com> <15418.15099.922688.165706@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15418.15099.922688.165706@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Jan 08, 2002 at 11:19:07AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:19:07AM +1100, Paul Mackerras wrote:
> Is the "r" constraint available (and reasonable) on all architectures
> that GCC targets?

Yes, though "g" is probably better for this purpose.


r~
