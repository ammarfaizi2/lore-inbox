Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285607AbRLGWLb>; Fri, 7 Dec 2001 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285606AbRLGWLW>; Fri, 7 Dec 2001 17:11:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41740 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285605AbRLGWLH>; Fri, 7 Dec 2001 17:11:07 -0500
Message-ID: <3C113E6D.2030504@zytor.com>
Date: Fri, 07 Dec 2001 14:10:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jan Dvorak <johnydog@go.cz>
CC: Mateusz ?oskot <m.loskot@chello.pl>, linux-kernel@vger.kernel.org,
        ftpadmin@kernel.org
Subject: Re: Strange problem with 2.4.x kernel
In-Reply-To: <20011206190454.B848@cheetah.chello.pl> <20011206123342.42179ed3.reynolds@redhat.com> <20011206194151.D848@cheetah.chello.pl> <20011207222457.A939@go.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dvorak wrote:

> (CCing to ftpadmin@kernel.org)
> 
> On Thu, Dec 06, 2001 at 07:41:51PM +0100, Mateusz ?oskot wrote:
> 
>>Dni 06.12 2001 r., o godzinie 12:33 Tommy Reynolds napisa?(a) co nast?puje:
>>
> ..
> 
>>>Use ftp(1) or wget(1) to do the downloads.  Do _not_ try to get the files using
>>>any web browser, such as Netscape, because they are known to mangle files that
>>>they don't understand.
>>>
>>I know, I used only ftp, ncftp or yafc - the same result ;-((((
>>
>>Thanks
>>
> 
> What is your line speed ? ProFTPD 1.2.0rcX and 1.2.2rcX (and probably other
> versions) corrupts data on slow links (e.g modem) when compiled with
> --enable-sendfile option (default). Could you try downloading on fast link,
> or from mirrors ?
> 
> To ftpadmin@kernel.org:
> Could you please check ? Thanks.
> 


We're currently running ProFTPD 1.2.2 final (with sendfile enabled.)
We're planning a full server replacement before the end of the month, at
which time we'll probably replace it with vsftpd.

	-hpa


