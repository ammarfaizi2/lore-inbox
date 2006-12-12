Return-Path: <linux-kernel-owner+w=401wt.eu-S1751223AbWLLKqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWLLKqH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWLLKqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:46:07 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:63289 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223AbWLLKqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:46:04 -0500
Date: Tue, 12 Dec 2006 12:46:01 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-ID: <20061212104601.GA21258@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061205172512.GA5518@m.safari.iki.fi> <20061205223945.8c81ea91.akpm@osdl.org> <20061206094138.GA15365@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206094138.GA15365@m.safari.iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:41:38 +0200, Sami Farin wrote:
> On Tue, Dec 05, 2006 at 22:39:45 -0800, Andrew Morton wrote:
> > On Tue, 5 Dec 2006 19:25:13 +0200
> > Sami Farin <7atbggg02@sneakemail.com> wrote:
> > 
> > > [1.] PROBLEM: 2.6.19 + highmem = BUG at do_wp_page 
> > 
> > Can you send the .config please?
> 
> I happened to modify configuration a bit,
> CONFIG_HIGHMEM4G to CONFIG_HIGHMEM64G
> and added CONFIG_X86_MCE_P4THERMAL=y.
> Otherwise this should be pretty close.
> I haven't tried to boot with CONFIG_HIGHMEM64G yet.

CONFIG_HIGHMEM64G=y doesn't work, either, in case someone cares.

With mem=896M highmem-enabled kernels work OK.

-- 
