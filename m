Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSFROUo>; Tue, 18 Jun 2002 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSFROUn>; Tue, 18 Jun 2002 10:20:43 -0400
Received: from ns.suse.de ([213.95.15.193]:778 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317426AbSFROUm>;
	Tue, 18 Jun 2002 10:20:42 -0400
Date: Tue, 18 Jun 2002 16:20:43 +0200
From: Dave Jones <davej@suse.de>
To: "White, Charles" <Charles.White@hp.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Filip Sneppe <filip.sneppe@chello.be>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Arrays <arrays@hp.com>
Subject: Re: 2.4.19-pre10 link error - cpqarray related ?
Message-ID: <20020618162043.T758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"White, Charles" <Charles.White@hp.com>,
	Adrian Bunk <bunk@fs.tum.de>, Filip Sneppe <filip.sneppe@chello.be>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>, Arrays <arrays@hp.com>
References: <A2C35BB97A9A384CA2816D24522A53BB01E88FF0@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB01E88FF0@cceexc18.americas.cpqcorp.net>; from Charles.White@hp.com on Tue, Jun 18, 2002 at 09:11:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 09:11:23AM -0500, White, Charles wrote:
 > Interesting... It compiled for me fine.  Both statically and dynamic. 
 >  
 > What version of the compiler are you using?

__devexit/__devexit_p problems are a binutils issue.
Likely you have an older binutils which doesn't exhibit this problem.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
