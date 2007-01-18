Return-Path: <linux-kernel-owner+w=401wt.eu-S1752051AbXAROnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXAROnj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXAROnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:43:39 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:40658 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752049AbXAROni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:43:38 -0500
Message-ID: <45AF8796.8030703@scientia.net>
Date: Thu, 18 Jan 2007 15:43:34 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: andersen@codepoet.org, Andi Kleen <ak@suse.de>,
       Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de> <20070118110028.GA22407@codepoet.org>
In-Reply-To: <20070118110028.GA22407@codepoet.org>
Content-Type: multipart/mixed;
 boundary="------------030001030206070300090204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001030206070300090204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Erik Andersen wrote:
> I just tried again and while using iommu=soft does avoid the
> corruption problem, as with previous kernels with 2.6.20-rc5
> using iommu=soft still makes my pcHDTV HD5500 DVB cards not work.
> I still have to disable memhole and lose 1 GB.  :-(

Please add this to the bugreport
(http://bugzilla.kernel.org/show_bug.cgi?id=7768)

Chris.

--------------030001030206070300090204
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030001030206070300090204--
