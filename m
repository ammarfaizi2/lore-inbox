Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263138AbTCSUJT>; Wed, 19 Mar 2003 15:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCSUJS>; Wed, 19 Mar 2003 15:09:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263138AbTCSUJP>; Wed, 19 Mar 2003 15:09:15 -0500
Message-ID: <3E78D0DE.307@zytor.com>
Date: Wed, 19 Mar 2003 12:19:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Deprecating .gz format on kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

At some point it probably would make sense to start deprecating .gz
format files from kernel.org.

I am envisioning this as a three-phase changeover:

a) Get all mirrors to carry .bz2 format.  This would affect the
following sites:

DUTH:format=gz
GARBO:format=gz
HCMC:format=gz
IGLU:format=gz
LINUXAID:format=gz
LLARIAN-NET:format=gz
MINET-FR:format=gz
NC-ORC:format=gz
PCSS:format=gz
PROGRAMVAREVERKSTEDET:format=gz
PUB-FTP-UNIVERSITY-OF-OLDENBURG:format=gz
RN-RNO:format=gz
TASK:format=gz
TELEPAC:format=gz
TENGU-EASYNET-FR:format=gz
UNC-METALAB:format=gz
WEBLAB:format=gz

b) Once that is done, change the robots to no longer require .gz files;
.bz2 files uploaded would be signed but no .gz file would be generated.

-> If we get a complete loss of data here, all .gz files would be lost.

c) At some point, deprecate .gz uploads entirely and remove all the old
.gz files.  After that point .gz files uploaded would be treated just
like .Z, .zip or any other "unmanaged" compression format.


Now, the questions that come up are:

i) Does this sound reasonable to everyone?  In particular, is there any
loss in losing the "original" compressed files?

ii) Assuming a yes on the previous question, what time frame would it
make sense for this changeover to happen over?

	-hpa

