Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285556AbRLGVZj>; Fri, 7 Dec 2001 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285558AbRLGVZ3>; Fri, 7 Dec 2001 16:25:29 -0500
Received: from router.go.cz ([62.24.72.72]:16256 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S285556AbRLGVZR>;
	Fri, 7 Dec 2001 16:25:17 -0500
Date: Fri, 7 Dec 2001 22:24:58 +0100
From: Jan Dvorak <johnydog@go.cz>
To: Mateusz ?oskot <m.loskot@chello.pl>, linux-kernel@vger.kernel.org
Cc: ftpadmin@kernel.org
Subject: Re: Strange problem with 2.4.x kernel
Message-ID: <20011207222457.A939@go.cz>
Mail-Followup-To: Mateusz ?oskot <m.loskot@chello.pl>,
	linux-kernel@vger.kernel.org, ftpadmin@kernel.org
In-Reply-To: <20011206190454.B848@cheetah.chello.pl> <20011206123342.42179ed3.reynolds@redhat.com> <20011206194151.D848@cheetah.chello.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <20011206194151.D848@cheetah.chello.pl>; from m.loskot@chello.pl on Thu, Dec 06, 2001 at 07:41:51PM +0100
Organization: (www.kraxnet.cz)
X-URL: http://www.johnydog.cz/
X-OS: Linux 2.4.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CCing to ftpadmin@kernel.org)

On Thu, Dec 06, 2001 at 07:41:51PM +0100, Mateusz ?oskot wrote:
> Dni 06.12 2001 r., o godzinie 12:33 Tommy Reynolds napisa?(a) co nast?puje:
..
> > Use ftp(1) or wget(1) to do the downloads.  Do _not_ try to get the files using
> > any web browser, such as Netscape, because they are known to mangle files that
> > they don't understand.
> 
> I know, I used only ftp, ncftp or yafc - the same result ;-((((
> 
> Thanks

What is your line speed ? ProFTPD 1.2.0rcX and 1.2.2rcX (and probably other
versions) corrupts data on slow links (e.g modem) when compiled with
--enable-sendfile option (default). Could you try downloading on fast link,
or from mirrors ?

To ftpadmin@kernel.org:
Could you please check ? Thanks.

Jan Dvorak <johnydog@go.cz>

