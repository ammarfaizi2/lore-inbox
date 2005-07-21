Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVGUX15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVGUX15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGUX15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:27:57 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:24562 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261880AbVGUX14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=VALsHfMF6RZIqWmgmuGy4p0utgCxn1Ptq9uw5b2ThVi6h1pu9WvY7a4j0vBIS2cx+6DoJY42JxdGhXrteE06b5qyChGd+4rDlcJxZPDFPWxK2bvQTlP9k+F1jkFZec0tL7rSfbINNuzS13AgU2iVET116OwExrnK2dgtYMKdNIw=
Message-ID: <9a874849050721162778dba354@mail.gmail.com>
Date: Fri, 22 Jul 2005 01:27:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Steve French <smfltc@us.ibm.com>
Subject: Re: CIFS slowness & crashes
Cc: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>,
       linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org
In-Reply-To: <1121985312.26833.28.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15139_25136645.1121988436949"
References: <42E01163.3090302@trn.iki.fi>
	 <9a87484905072115041cc576a4@mail.gmail.com>
	 <1121985312.26833.28.camel@stevef95.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15139_25136645.1121988436949
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 21 Jul 2005 17:35:12 -0500, Steve French <smfltc@us.ibm.com> wrote:
> Yes.  CCing those lists is recommended.  The best list to send to is and
> which I and others in this area monitor regularly though is
> linux-cifs-client@lists.samba.org

If that's the best list to send to, then I suggest it be added to the
CIFS MAINTAINERS entry as pr the patch below (also attached since
gmail will probably mangle it).


Add linux-cifs-client@lists.samba.org to CIFS entry in MAINTAINERS

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 MAINTAINERS |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.13-rc3-orig/MAINTAINERS   2005-07-14 20:33:32.000000000 +0200
+++ linux-2.6.13-rc3/MAINTAINERS        2005-07-22 01:42:09.000000000 +0200
@@ -532,6 +532,7 @@
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:     Steve French
 M:     sfrench@samba.org
+L:     linux-cifs-client@lists.samba.org
 L:     samba-technical@lists.samba.org
 W:     http://us1.samba.org/samba/Linux_CIFS_client.html
 S:     Supported


--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_15139_25136645.1121988436949
Content-Type: text/x-patch; name="CIFS_add_linux-cifs-client_list_to_MAINTAINERS.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="CIFS_add_linux-cifs-client_list_to_MAINTAINERS.patch"

RnJvbTogSmVzcGVyIEp1aGwgPGplc3Blci5qdWhsQGdtYWlsLmNvbT4KCkFkZCBsaW51eC1jaWZz
LWNsaWVudEBsaXN0cy5zYW1iYS5vcmcgdG8gQ0lGUyBlbnRyeSBpbiBNQUlOVEFJTkVSUwoKU2ln
bmVkLW9mZi1ieTogSmVzcGVyIEp1aGwgPGplc3Blci5qdWhsQGdtYWlsLmNvbT4KCgotLS0gbGlu
dXgtMi42LjEzLXJjMy1vcmlnL01BSU5UQUlORVJTCTIwMDUtMDctMTQgMjA6MzM6MzIuMDAwMDAw
MDAwICswMjAwCisrKyBsaW51eC0yLjYuMTMtcmMzL01BSU5UQUlORVJTCTIwMDUtMDctMjIgMDE6
NDI6MDkuMDAwMDAwMDAwICswMjAwCkBAIC01MzIsNiArNTMyLDcgQEAKIENPTU1PTiBJTlRFUk5F
VCBGSUxFIFNZU1RFTSAoQ0lGUykKIFA6CVN0ZXZlIEZyZW5jaAogTToJc2ZyZW5jaEBzYW1iYS5v
cmcKK0w6CWxpbnV4LWNpZnMtY2xpZW50QGxpc3RzLnNhbWJhLm9yZwogTDoJc2FtYmEtdGVjaG5p
Y2FsQGxpc3RzLnNhbWJhLm9yZwogVzoJaHR0cDovL3VzMS5zYW1iYS5vcmcvc2FtYmEvTGludXhf
Q0lGU19jbGllbnQuaHRtbAogUzoJU3VwcG9ydGVkCQo=
------=_Part_15139_25136645.1121988436949--
