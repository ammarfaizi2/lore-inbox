Return-Path: <linux-kernel-owner+w=401wt.eu-S1751454AbXAOW0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXAOW0e (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAOW0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:26:34 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:57290 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751454AbXAOW0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:26:33 -0500
Message-ID: <45ABFF95.1000105@scientia.net>
Date: Mon, 15 Jan 2007 23:26:29 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: mistysga@googlemail.com
CC: Chris Wedgwood <cw@f00f.org>, Karsten Weiss <knweiss@gmx.de>,
       linux-kernel@vger.kernel.org, ak@suse.de, andersen@codepoet.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <Pine.LNX.4.64.0612021048200.2981@addx.localnet> <45804C0B.4030109@scientia.net> <Pine.LNX.4.64.0612132014340.2963@addx.localnet> <45805E71.6060006@scientia.net> <20061214093428.GA1086@tuatara.stupidest.org>
In-Reply-To: <20061214093428.GA1086@tuatara.stupidest.org>
Content-Type: multipart/mixed;
 boundary="------------080401090101060403000203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080401090101060403000203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

Some days ago I received the following message from "Sunny Days". I
think he did not send it lkml so I forward it now:

Sunny Days wrote:
> hello,
>
> i have done some extensive testing on this.
>
> various opterons, always single socket
> various dimms 1 and 2gb modules
> and hitachi+seagate disks with various firmwares and sizes
> but i am getting a diferent pattern in the corruption.
> My test file was 10gb.
>
> I have mapped the earliest corruption as low as 10mb in the written data.
> i have also monitor the adress range used from the cp /md5sum proccess
> under /proc//$PID/maps to see if i could find a pattern but i was
> unable to.
>
> i also tested ext2 and lvm with similar results aka corruption.
> later on the week i should get a pci promise controller and test on that one.
>
> Things i have not tested is the patch that linus released 10 days ago
> and reiserfs3/4
>
> my nvidia chipset was ck804 (a3)
>
> Hope somehow we get to the bottom of this.
>
> Hope this helps
>
>
> btw amd erratas that could possible influence this are
>
> 115, 123, 156 with the latter been fascinating as it the workaround
> suggested is 0x0 page entry.
>
>   

Does anyone has any opinions about this? Could you please read the
mentioned erratas and tell me what you think?

Best wishes,
Chris.

@ Sunny Days: Thanks for you mail.

--------------080401090101060403000203
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------080401090101060403000203--
